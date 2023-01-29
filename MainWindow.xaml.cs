using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace WpfApp1;


public partial class MainWindow : Window
{
    IConfigurationRoot? configurationRoot=null;
    string? conStr = string.Empty;
    SqlConnection? conn = null;
    SqlDataReader? reader = null;
    DataTable? table = null;
    SqlTransaction? transaction = null;

    SqlCommandBuilder? builder = null;
    DataSet? dataset = null;
    SqlDataAdapter? adapter = null;

    public MainWindow()
    {
        InitializeComponent();
        Configure();
        Add_Allproducts();
    }

    private void Configure()
    {
        string projectPath = Directory.GetCurrentDirectory().Split(@"bin\")[0];

        configurationRoot =new ConfigurationBuilder()
            .SetBasePath(projectPath)
            .AddJsonFile("appsettings.json")
            .Build();
        conStr = configurationRoot.GetConnectionString("db1");
        
    }

    private async void Add_Allproducts()
    {
        conn = new SqlConnection(conStr);
        try
        {
            await conn.OpenAsync();
            MessageBox.Show("plese wait 5 second products loaded");
            string selcommand = "SELECT Id,Products.[Name],Price,Products.Quantitiy\r\nFROM Products";

            SqlCommand cmd=conn.CreateCommand();
            cmd.CommandText = "WAITFOR DELAY '00:00:03';";
            cmd.CommandText += selcommand;
            table=new DataTable();


            adapter = new SqlDataAdapter(selcommand, conn);
            dataset = new DataSet();
            adapter.Fill(dataset);

            reader = await cmd.ExecuteReaderAsync();

            int line = 0;

            do
            {
                while (await reader.ReadAsync())
                {
                    if (line == 0)
                    {
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            table.Columns.Add(reader.GetName(i));
                        }
                        line++;
                    }
                    DataRow row = table.NewRow();

                    for (int i = 0; i < reader.FieldCount; i++)
                        row[i] = await reader.GetFieldValueAsync<object>(i);


                    table.Rows.Add(row);
                    
                }
            } while (reader.NextResult());

            Gridviev1.ItemsSource = null;
            Gridviev1.ItemsSource = table.AsDataView();
            
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message);
        }
        finally
        { 
            await conn.CloseAsync();
            await reader.CloseAsync();
        }
    }

    private async void Add_Category()
    {
        bool contains = false;
        foreach (var item in category_Cmbx.Items)
        {
            if (item.ToString() != string.Empty)
            {
                contains = true;
                break;
            }
        }
        if (!contains)
        {
            conn = new SqlConnection(conStr);
            try
            {
                await conn?.OpenAsync();
                string selCommand = "SELECT [Name] FROM Categories";
                using SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText += selCommand;
                reader = await cmd.ExecuteReaderAsync();



                while (await reader.ReadAsync())
                {
                    category_Cmbx.Items.Add(reader[0]);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                await conn.CloseAsync();
                await reader?.CloseAsync();
            }
        }
    }

    private async void category_Cmbx_SelectionChanged(object sender, SelectionChangedEventArgs e)
    {
        Gridviev1.ItemsSource=null;
        try
        {
            await conn?.OpenAsync();
            string selcom = @"SELECT Products.[Name],Products.Price,Products.Quantitiy
                              From Products
                              JOIN Categories ON CategoryId=Categories.id
                              WHERE Categories.Name=@p1";
        
            using SqlCommand cmd = conn.CreateCommand();
            //cmd.CommandText = "WAITFOR DELAY '00:00:05';";
            cmd.CommandText += selcom;
            cmd.Parameters.AddWithValue("@p1", category_Cmbx.SelectedItem.ToString());
            reader =await cmd.ExecuteReaderAsync();
        
            table=new DataTable();
        
            int line = 0;
            do
            {
                while (await reader.ReadAsync())
                {
                    if (line==0)
                    {
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            table.Columns.Add(reader.GetName(i));
                        }
                        line++;
                    }
                    DataRow row = table.NewRow();
        
                    for (int i = 0; i < reader.FieldCount; i++)
                        row[i] = await reader.GetFieldValueAsync<object>(i);
        
        
                    table.Rows.Add(row);
                }
            } while (reader.NextResult());
            //Gridviev1.ItemsSource = null;
            Gridviev1.ItemsSource=table.AsDataView();
            
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message, "Error");
            throw;
        }
        finally
        {
            await conn?.CloseAsync();
            await reader.CloseAsync();
        }
    }

    private void category_Cmbx_PreviewMouseDown(object sender, MouseButtonEventArgs e)
    {  
        //category_Cmbx.Items.Clear();
        Add_Category();
    }

    private void Search_TextBox_TextChanged(object sender, TextChangedEventArgs e)
    {
        if (adapter is null) return;
        dataset?.Clear();
        string txt = search_TextBox.Text;
        adapter.SelectCommand.CommandText = $"SELECT * FROM Products WHERE Name LIKE '%{txt}%'";
        adapter.Fill(dataset);
        foreach (DataTable item in dataset.Tables)
        {
            Gridviev1.ItemsSource = item.AsDataView();
        }
        adapter.SelectCommand.CommandText = "SELECT Id,Products.[Name],Price,Products.Quantitiy\r\nFROM Products";
    }

    private void Add_Btn_Click(object sender, RoutedEventArgs e)
    {
        
    }
}
