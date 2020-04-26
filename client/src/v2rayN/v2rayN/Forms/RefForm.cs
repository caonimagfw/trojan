using System;
using System.Windows.Forms;
using v2rayN.Handler;
using v2rayN.Mode;

namespace v2rayN.Forms
{
    public partial class RefForm : BaseForm
    {
        public int EditIndex { get; set; }
 

        public RefForm()
        {
            InitializeComponent();
        }

        private void RefForm_Load(object sender, EventArgs e)
        {
           
        }

     

    


        private void btnOK_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
        }

        
        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void ll1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            System.Diagnostics.Process.Start("https://app.cloudcone.com/?ref=5179");
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            System.Diagnostics.Process.Start("https://pacificrack.com/portal/aff.php?aff=1940");
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
