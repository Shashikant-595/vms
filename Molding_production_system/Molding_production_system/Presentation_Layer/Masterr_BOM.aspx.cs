using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Presentation_Layer
{
    public partial class Masterr_BOM : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnimg_addMetalrow_Click(object sender, ImageClickEventArgs e)
        {
            string firstval = txt_MetalSapcode1.Text;
            string secondval = txt_MetalSapcode2.Text;
            string thirdval = txt_MetalSapcode3.Text;
            string fourthval = txt_MetalSapcode4.Text;
            string fifthval = txt_MetalSapcode5.Text;

            if (!string.IsNullOrEmpty(firstval) && !textboxes2.Visible)
            {
                textboxes2.Visible = true;
            }
            else if (!string.IsNullOrEmpty(secondval) && !textboxes3.Visible)
            {
                textboxes3.Visible = true;
            }
            else if (!string.IsNullOrEmpty(thirdval) && !textboxes4.Visible)
            {
                textboxes4.Visible = true;
            }
            else if (!string.IsNullOrEmpty(fourthval) && !textboxes5.Visible)
            {
                textboxes5.Visible = true;
                btnimg_addMetalrow.Visible = false;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Insert Metal Data.');", true);
            }
        }

        protected void btnimg_removemetalrow_Click(object sender, ImageClickEventArgs e)
        {
            if (textboxes5.Visible)
            {
                txt_MetalSapcode5.Text = null;
                textboxes5.Visible = false;
                btnimg_addMetalrow.Visible = true;
            }
            else if (textboxes4.Visible)
            {
                txt_MetalSapcode4.Text = null;
                textboxes4.Visible = false;
            }
            else if (textboxes3.Visible)
            {
                txt_MetalSapcode3.Text = null;
                textboxes3.Visible = false;
            }
            else if (textboxes2.Visible)
            {
                txt_MetalSapcode2.Text = null;
                textboxes2.Visible = false;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('No more rows to remove.');", true);
            }
        }

        protected void txt_sapcode_TextChanged(object sender, EventArgs e)
        {
            string enteredText = txt_sapcode.Text;

            if (enteredText.Length != 10)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Insert Material SAP Code with exactly 10 characters.');", true);
                txt_sapcode.Text = "";
                return;
            }

            foreach (char c in (enteredText))
            {
                if ((c != 's' && c != 'S') && (c < '0' || c > '9'))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Insert Material SAP Code Only [0-9] and \"S\" are allowed.');", true);
                    txt_sapcode.Text = "";
                    return;
                }
            }
        }


        protected void txt_compoundSAPcode_TextChanged(object sender, EventArgs e)
        {
            string enteredText = txt_compoundSAPcode.Text;

            if (enteredText.Length != 10)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Insert Compound SAP Code with exactly 10 characters.');", true);
                txt_compoundSAPcode.Text = "";
                return;
            }

            foreach (char c in enteredText)
            {
                if (c != 'F' && c != 'f' && c != 'B' && c != 'b' && (c < '0' || c > '9'))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Insert Compound SAP Code Only [0-9] and \"FB\" are allowed.');", true);
                    txt_compoundSAPcode.Text = "";
                    return;
                }
            }
        }
    }
}