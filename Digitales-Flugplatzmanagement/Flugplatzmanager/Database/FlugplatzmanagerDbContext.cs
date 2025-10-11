using Microsoft.EntityFrameworkCore;

namespace Flugplatzmanager.Database
{
    public class FlugplatzmanagerDbContext: DbContext
    {
        // Dbsets fehlen noch
        public FlugplatzmanagerDbContext(DbContextOptions<FlugplatzmanagerDbContext> options)
            : base(options)
        {
        }
    }
}
