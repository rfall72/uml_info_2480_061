
 
<cftry>
    <cfparam name="book" default="">
    <cfparam name="qterm" default="">

    <cfset addEditFunctions = createObject("addedit") />
    <cfset addEditFunctions.processForms(form)>

    <div class="row">
        <div id="main" class="col-9">
            <cfoutput> #mainForm()#</cfoutput>
        </div>

        <div id=”leftgutter” class="col-lg-3 order-first">
            <cfoutput>#sideNav()#</cfoutput>
        </div>
    </div>
    <cfcatch type="any">
        <cfoutput>
            #cfcatch.Message#
        </cfoutput>
    </cfcatch>
</cftry>

<cffunction name="mainForm">

    <cfset allPublishers = addEditFunctions.allPublishers()>
    <cfset bookDetails = addEditFunctions.bookDetails(book)>
    <cfoutput>
        <form action="#cgi.script_name#?tool=addedit&qterm=#qterm#" method="post" enctype="multipart/form-data">
            <div class="form-floating mb-3">
                <input type="text" id="ISBN13" name="ISBN13" class="form-control" value="#bookDetails.ISBN13[1]#" placeholder="Enter the ISBN13" />
                <label for="ISBN13">ISBN13:</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" id="title" name="title" class="form-control" value="#bookDetails.title[1]#" placeholder="Book Title" />
                <label for="title">Book Title</label>
            </div>

            <div class="form-floating mb-3">
                <input type="number" id="year" name="year" class="form-control" value="#bookDetails.year[1]#" placeholder="Year" />
                <label for="year">Year</label>
            </div>

            <div class="form-floating mb-3">
                <input type="number" id="weight" name="weight" step=".1" class="form-control" value="#bookDetails.weight[1]#" placeholder="Weight" />
                <label for="weight">Weight(lb)</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" id="isbn" name="isbn" class="form-control" value="#bookDetails.isbn[1]#" placeholder="isbn" />
                <label for="isbn">isbn</label>
            </div>

            <div class="form-floating mb-3">
                <input type="number" id="pages" name="pages" class="form-control" value="#bookDetails.pages[1]#" placeholder="Page Number" />
                <label for="pages">Pages</label>
            </div>

            <div class="form-floating mb-3">
                <select class="form-select" id="publisherID" name="publisherID" aria-label="Publisher Select Control">
                    <option value=""></option>
                    <cfloop query="allPublishers">
                        <option value="#publisherID#" #bookDetails.publisherID eq publisherID ? "selected" : "" #>#name#</option>
                    </cfloop>
                </select>
                <label for="publisherID">Publisher</label>

            </div>

            <div class="row">
                <div class="col">
                    <label for="uploadImage">Upload Cover</label>
                    <div class="input-group mb-3">
                        <input type="file" id="uploadimage" name="uploadimage" class="form-control" />
                        <input type="hidden" name="image" value="#trim(bookDetails.image[1])#" />
                    </div>
                </div>

            <div class="col">
                <cfif bookDetails.image[1].len() gt 0 >
                    <img src="../images/#trim(bookDetails.image[1])#" style="width:200px" />
                </cfif>
            </div>
        </div> 
    
    <div class="form-floating mb-3">
        <div>
            <label for="description">Description</label>
        </div>
        <textarea id="description" name="description">
            <cfoutput>#bookDetails.description#</cfoutput>
        </textarea>
        <script>
            ClassicEditor.create(document.querySelector('##description')).catch(error => {console.dir(error)});
        </script>
    </div>     


            <button type="submit" class="btn btn-primary" style="width:100%">Add Book</button>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="sideNav">

    <cfset allbooks = addEditFunctions.sideNavBooks(qterm) />
        <div>
            Book List
        </div>
        <cfoutput>
         #findBookForm()#
        </cfoutput>
        <cfoutput>
            <ul class="nav flex-column">
             <li class="nav-item">
                 <a href="#cgi.script_name#?tool=addedit&book=new" class="nav-link">
                     New Book
                 </a>
             </li>
             <cfif qterm.len()== 0 >
                 No Serch Term Entered
             <cfelseif allBooks.recordcount == 0 >
                 No Result Found
             <cfelse>
                <cfloop query="allbooks">
                    <li class="nav-item">
                        <a href="#cgi.script_name#?tool=addedit&book=#ISBN13#&qterm=#qterm#" class="nav-link">#trim(title)#</a>
                    </li>
                </cfloop>
                </cfif>
            </ul>
        </cfoutput>
</cffunction>

<cffunction name="findBookForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory </label>
            </div>
        </form>
    </cfoutput>
</cffunction>