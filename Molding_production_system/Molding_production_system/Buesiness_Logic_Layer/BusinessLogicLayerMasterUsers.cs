using Data_Access_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Buesiness_Logic_Layer
{
    public class BusinessLogicLayerMasterUsers
    {
        private DataAccessLayerMasterUser dal = new DataAccessLayerMasterUser();

        public void SaveUser(string userType, string username, string password)
        {
            dal.SaveUser(userType, username, password);
        }

        public void UpdateUser(string userType, string username, string password)
        {
            dal.UpdateUser(userType, username, password);
        }

        public DataTable GetUsers()
        {
            return dal.SelectUsers();
        }
    }
}
