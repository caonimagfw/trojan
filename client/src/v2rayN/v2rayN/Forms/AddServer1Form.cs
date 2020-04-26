using System;
using System.Windows.Forms;
using v2rayN.Handler;
using v2rayN.Mode;

namespace v2rayN.Forms
{
    public partial class AddServer1Form : BaseForm
    {
        public int EditIndex { get; set; }
        VmessItem vmessItem = null;

        public AddServer1Form()
        {
            InitializeComponent();
        }

        private void AddServerForm_Load(object sender, EventArgs e)
        {
            if (EditIndex >= 0)
            {
                vmessItem = config.vmess[EditIndex];
                BindingServer();
            }
            else
            {
                vmessItem = new VmessItem();
                ClearServer();
            }
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        private void BindingServer()
        {
            txtAddress.Text = vmessItem.address;
            txtPort.Text = vmessItem.port.ToString();
            txtPassword.Text = vmessItem.id;
            txtRemarks.Text = vmessItem.remarks;
        }


        /// <summary>
        /// 清除设置
        /// </summary>
        private void ClearServer()
        {
            txtAddress.Text = "";
            txtPort.Text = "";
            txtPassword.Text = "";
            txtRemarks.Text = "";
        }



        private void btnOK_Click(object sender, EventArgs e)
        {
            string address = txtAddress.Text;
            string port = txtPort.Text;
            string password = txtPassword.Text;            
            string remarks = txtRemarks.Text;

            //# string allowInsecure = cmbAllowInsecure.Text;

            if (Utils.IsNullOrEmpty(address))
            {
                UI.Show(UIRes.I18N("FillServerAddress"));
                return;
            }
            if (Utils.IsNullOrEmpty(port) || !Utils.IsNumberic(port))
            {
                UI.Show(UIRes.I18N("FillCorrectServerPort"));
                return;
            }
            if (Utils.IsNullOrEmpty(password))
            {
                UI.Show(UIRes.I18N("FillPassword"));
                return;
            }
            if (Utils.IsNullOrEmpty(remarks) )
            {
                UI.Show(UIRes.I18N("PleaseFillRemarks"));
                return;
            }

            vmessItem.address = address;
            vmessItem.port = Utils.ToInt(port);
            vmessItem.id = password;
            vmessItem.remarks = remarks;            

            if (ConfigHandler.AddTrojanServer(ref config, vmessItem, EditIndex) == 0)
            {
                this.DialogResult = DialogResult.OK;
            }
            else
            {
                UI.ShowWarning(UIRes.I18N("OperationFailed"));
            }
        }

        private void btnGUID_Click(object sender, EventArgs e)
        {
            txtPassword.Text = Utils.GetGUID();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
        }

        
        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
