using Microsoft.EntityFrameworkCore;

namespace Flugplatzmanager.Database
{
    public static class MigrationExtension
    {
        public static void ApplyMigrations(this IApplicationBuilder app)
        {
            using IServiceScope scope = app.ApplicationServices.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<FlugplatzmanagerDbContext>();
            dbContext.Database.Migrate();
        }
    }
}
