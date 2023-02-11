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
//using static System.Runtime.InteropServices.JavaScript.JSType;

namespace WpfApp1;


public partial class MainWindow : Window
{
    IConfigurationRoot? configurationRoot=null;
    string? conStr = string.Empty;
    SqlConnection? conn = null;

    SqlDataReader? reader = null;
    DataTable? table = null;

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
            string selcommand = "SELECT Id,Products.[Name],Price,Products.Quantity\r\nFROM Products";

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
        //Gridviev1.ItemsSource=null;
        try
        {
            await conn?.OpenAsync();
            string selcom = @"SELECT Products.[Name],Products.Price,Products.Quantity
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
            Gridviev1.ItemsSource = null;
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
        adapter.SelectCommand.CommandText = "SELECT Id,Products.[Name],Price,Products.Quantity\r\nFROM Products";
    }

    private void Add_Btn_Click(object sender, RoutedEventArgs e)
    {
        AddWindow addWindow= new AddWindow();
        Close();
        addWindow.Show();
        
    }

    private void Gridviev1_MouseDoubleClick(object sender, MouseButtonEventArgs e)
    {
        
        var selectedItem = (sender as DataGrid).SelectedItem;
        

        if (selectedItem != null)
        {
            var rowView = selectedItem as DataRowView;
            var data = rowView["Id"];
            var data1 = rowView["Name"];
            var data2 = rowView["Price"];
            var data3 = rowView["Quantity"];
           
            //MessageBox.Show(data.ToString());

            OpenInfoWindow(data,data1, data2, data3);
        }
    }
    private void OpenInfoWindow(object data, object data1, object data2, object data3)
    {
        InfoWindow infoWindow = new InfoWindow();
        infoWindow._selectedItem = data;
        infoWindow._selectedItem1 = data1;
        infoWindow._selectedItem2 = data2;
        infoWindow._selectedItem3 = data3;
        
        infoWindow.ShowDialog();
    }

    private void Update_btn_Click(object sender, RoutedEventArgs e)
    {
        
        SqlCommand updateCM = new SqlCommand()
        {
            CommandText = "usp_UpdateProducts",
            Connection = conn,
            CommandType = CommandType.StoredProcedure,
        };
        

        updateCM.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int));
        updateCM.Parameters.Add(new SqlParameter("@Name", SqlDbType.NVarChar));
        //updateCM.Parameters.Add(new SqlParameter("@CategoryId", SqlDbType.Int));
        updateCM.Parameters.Add(new SqlParameter("@Price", SqlDbType.Money));
        updateCM.Parameters.Add(new SqlParameter("@Quantity", SqlDbType.SmallInt));
        //updateCM.Parameters.Add(new SqlParameter("@RatingId", SqlDbType.Int));


        updateCM.Parameters["@Id"].SourceVersion = DataRowVersion.Original;
        updateCM.Parameters["@Id"].SourceColumn = "Id";

        updateCM.Parameters["@Name"].SourceVersion = DataRowVersion.Current;
        updateCM.Parameters["@Name"].SourceColumn = "Name";

        updateCM.Parameters["@Price"].SourceVersion = DataRowVersion.Current;
        updateCM.Parameters["@Price"].SourceColumn = "Price";

        updateCM.Parameters["@Quantity"].SourceVersion = DataRowVersion.Current;
        updateCM.Parameters["@Quantity"].SourceColumn = "Quantity";


        adapter.UpdateCommand = updateCM;
        try
        {
            adapter.Update(dataset);

        }
        catch (SqlException ex)
        {
            MessageBox.Show(ex.Message);
        }

    }

    private async void Delete_btn_Click(object sender, RoutedEventArgs e)
    {
        DataRowView rowView = Gridviev1.SelectedItem as DataRowView;
        if (rowView != null)
        {
            DataRow row = rowView.Row;
            string Id = row[0].ToString();

            using (SqlConnection conn = new SqlConnection(conStr))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("DELETE FROM Products WHERE Id = @Id", conn);
                cmd.Parameters.AddWithValue("@Id", Id);
                int result = await cmd.ExecuteNonQueryAsync();
                if (result > 0)
                {
                    row.Delete();
                }
            }
        }
    }
}
