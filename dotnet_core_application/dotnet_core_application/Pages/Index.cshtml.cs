using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text;
using System.Web;
using System.Text.RegularExpressions;
using Microsoft.EntityFrameworkCore;

namespace dotnet_core_application.Pages
{
    public class IndexModel : PageModel
    {
        public IList<Guest> Guests { get; private set; }

        public async Task OnGetAsync()
        {
            Guests = await _db.Guests.AsNoTracking().ToListAsync();
        }

        private readonly AppDbContext _db;

        public IndexModel(AppDbContext db)
        {
            _db = db;
        }

        [BindProperty]
        public Guest Guest { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _db.Guests.Add(Guest);
            await _db.SaveChangesAsync();
            return RedirectToPage("/Index");
        }
        /*
        public void OnGet()
        {

        }
        */
    }
}
