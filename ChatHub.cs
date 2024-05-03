using Microsoft.AspNet.SignalR;
using System.Threading.Tasks;

namespace VMS
{
    public class ChatHub : Hub
    {
        public async Task SendVisitorCount(int newCount)
        {
            await Clients.All.SendAsync("ReceiveVisitorCount", newCount);
        }
    }
}