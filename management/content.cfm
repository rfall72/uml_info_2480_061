 
<cftry>
    <cfparam name="contentID" default="">

    <cfset contentFunctions = createObject("content") />

    <cfif form.keyExists("title")>
        <cfset contentFunctions.processContent( form ) />
    </cfif>

    <cfset allContent = contentFunctions.allContent() />

    <div class="row">
        <div id=”leftgutter” class="col-lg-3 order-first">
            <cfoutput query="allContent">
                <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=content&contentID=#contentID#">#trim(title)#</a>
            </cfoutput>
        </div>

        <div id="main" class="col-9">
            <cfoutput> #mainForm()#</cfoutput>
        </div>


    </div>

    <cfcatch type="any">
        <cfoutput>
            #cfcatch.Message#
        </cfoutput>
    </cfcatch>
</cftry>


<cffunction name="mainForm">
    <cfset contentData = contentFunctions.obtainArticle( contentID ) />
    <cfoutput>
        <form action="#cgi.script_name#?tool=content" method="post">
            <input type="hidden" name="contentid" value="#contentID#" />
            <div class="form-floating mb-3">
                <input type="text" id="title" name="title" class="form-control" value="#contentData.title#" placeholder="Title" />
                <label for="title">Title</label>
            </div>

        <div class="form-floating mb-3">
            <div>
                <label for="description">Description</label>
            </div>
            <textarea id="description" name="description">
                <cfoutput>#contentData.description#</cfoutput>
            </textarea>
            <script>
                ClassicEditor.create(document.querySelector('##description')).catch(error => {console.dir(error)});
            </script>
        </div>     
            <button type="submit" class="btn btn-primary" style="width:100%" value="Save">Save</button>
        </form>
    </cfoutput>
</cffunction>
