<cfset bookstoreFunctions = createObject("bookstore") />
<cfset bookGenres = bookstoreFunctions.obtainGenre() >
<section id="left" class="col-sm-3 order-first">
            <h3>Search By Genre</h3>
            <ul class="nav flex-column">
            <cfoutput>
                <cfloop query="bookGenres">
            
                <li class="nav-item"><a class="nav-link" href="#cgi.script_name#?p=details&genre=#genreID#">#genreName#</a></li>

                </cfloop>
            </cfoutput>
            </ul> 
        </section>