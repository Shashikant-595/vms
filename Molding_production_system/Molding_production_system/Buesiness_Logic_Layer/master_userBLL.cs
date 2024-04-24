using Data_Access_Layer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Buesiness_Logic_Layer
{
    public class master_userBLL
    {

        public bool SaveUser(string userType, string username, string password)
        {
            master_userDAL dal = new master_userDAL();
            return dal.SaveUser(userType, username, password);
        }

        public List<string> GetAllUsernames()
        {
            master_userDAL dal = new master_userDAL();
            return dal.GetAllUsernames();
        }

      

    }
}
