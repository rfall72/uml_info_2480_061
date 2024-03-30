
<cfparam name="searchme" default="">
<cfparam name="genre" default="">

<cfset bookstoreFunctions = createObject("bookstore") />
<cfset bookInfo = bookstoreFunctions.obtainSearchResults(searchme, genre) />


<cfif bookInfo.recordcount == 0 >
    <cfoutput>
    #noResults()#
    </cfoutput>
<cfelseif bookInfo.recordcount == 1 >
    <cfoutput>
    #oneResult()#
    </cfoutput>
<cfelse>
    <cfoutput>
    #manyResults()#
    </cfoutput>
</cfif>



<cffunction name="noResults">
    There were no results to be found.
</cffunction>

<cffunction name="oneResult">
    <h2>Search Result</h2>
    There was one result: </br>
    <cfoutput>
        <img src="images/#bookInfo.image[1]#" style="float:left; width:250px; height:250px" /> 
        <span>Title: #bookInfo.title[1]#</span> </br>
        <span>Publisher: #bookInfo.name[1]#</span> </br>
        <span>Year: #bookInfo.year[1]#</span> </br>
        <span>Pages: #bookInfo.pages[1]#</span> </br>
        <span>Description: #bookInfo.description[1]#</span>
    </cfoutput>
</cffunction>

<cffunction name="manyResults">
    <div>
        <h3>
            <cfif searchme.len()!=0>
            <cfoutput>
                keyword: #bookstoreFunctions.resultsHeader(searchme)#
            </cfoutput>
            </cfif>
        <h3>
    </div>
    There was more than one result:
        <ul class="nave flex-column">
            <cfoutput query="bookInfo">
                <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(ISBN13)#">
                        #trim(title)#
                    </a>
                </li>
            </cfoutput>
        </ul>
</cffunction>