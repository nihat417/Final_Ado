using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;

namespace WpfApp1;

/// <summary>
/// Interaction logic for AddWindow.xaml
/// </summary>
public partial class AddWindow : Window
{

    IConfigurationRoot? configurationRoot = null;
    string? conStr = string.Empty;
    SqlConnection? conn = null;
    SqlTransaction? transaction = null;
    public AddWindow()
    {
        InitializeComponent();
        Configure();
    }

    private void Configure()
    {
        string projectPath = Directory.GetCurrentDirectory().Split(@"bin\")[0];

        configurationRoot = new ConfigurationBuilder()
            .SetBasePath(projectPath)
        .AddJsonFile("appsettings.json")
            .Build();
        conStr = configurationRoot.GetConnectionString("db1");

    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
        conn = new SqlConnection(conStr);
        SqlTransaction? transaction = null;


        try
        {
            conn.Open();

            transaction = conn.BeginTransaction();

            using SqlCommand command = conn.CreateCommand();
            command.Transaction = transaction;     

            command.CommandText = @"INSERT INTO Products VALUES(@NameProduct,@Category,@Price,@Quantity,@Raiting)";
            command.Parameters.AddWithValue("@NameProduct", Nametxt.Text.ToString());
            command.Parameters.AddWithValue("@Category", Categorytxt.Text.ToString());
            command.Parameters.AddWithValue("@Price", Pricetxt.Text.ToString());
            command.Parameters.AddWithValue("@Quantity", Quantitytxt.Text.ToString());
            command.Parameters.AddWithValue("@Raiting", Raitingtxt.Text.ToString());

            command.ExecuteNonQuery();

            transaction.Commit();
            MessageBox.Show("Commit");

        }
        catch (Exception ex)
        {
            MessageBox.Show($"Rollback {ex.Message}");
            transaction?.Rollback();
        }
        finally
        {
            conn?.Close();
        }
    }

    private void CancelButton_Click(object sender, RoutedEventArgs e)
    {
        Window currentWindow = Application.Current.MainWindow;
        currentWindow.Visibility = Visibility.Hidden;
        MainWindow newWindow = new MainWindow();
        newWindow.Show();
    }
}
