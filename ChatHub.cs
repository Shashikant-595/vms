using Microsoft.AspNet.SignalR;
using System.Threading.Tasks;

namespace VMS
{
    public class ChatHub : Hub
    {
        public async Task ReceiveVisitorCount(int newCount)
        {
            await Clients.All.SendAsync("ReceiveVisitorCount", newCount);
        }
    }
}