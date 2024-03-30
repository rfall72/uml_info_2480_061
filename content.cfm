<cfparam name="contentID" default="" />


<cfset content = bookstoreFunctions.obtainArticle(contentID) />

<cfoutput>
    <h1>#content.title#</h1>
    <p>#content.description#</p>
</cfoutput>