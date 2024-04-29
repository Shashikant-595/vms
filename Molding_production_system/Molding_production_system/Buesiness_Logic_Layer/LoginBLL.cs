using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data_Access_Layer;

namespace Buesiness_Logic_Layer
{
    public class LoginBLL
    {
        private readonly UserValidator _userValidator;

        public LoginBLL()
        {
            _userValidator = new UserValidator();   
        }
        public String ValidateUser(string username, string password)
        {
            return _userValidator.ValidateUser(username, password);
        }
    }
}
