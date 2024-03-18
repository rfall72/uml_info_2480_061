
<cfset stateFunctions = createObject("stateinfo") />
<cfset session.clear() />

<cfif !session.keyExists("user")>
    <cfset session.user = stateFunctions.obtainUser() />
</cfif>

<cfif form.keyExists("firstName")>
    <cfset newAccountResult = stateFunctions.processNewAccount(form)/>
    <cfset accountMessage = newAccountResult.message />
</cfif>

<cfif form.keyExists("loginpass")>
    <cfset userData = stateFunctions.logMeIn(form.loginemail, form.loginpass) />
    <cfif userData.recordcount == 1>
        <cfset session.user=stateFunctions.obtainUser(
            isLoggedIn=1,
            firstName=userData.firstName,
            lastName=userData.lastName,
            email=userData.email,
            isAdmin=userData.isAdmin
        ) />
        <cfset p="carousel">
    <cfelse>
        <cfset loginMessage="Login and password not valid." />
    </cfif>
</cfif>

<cfif url.keyExists("p") && url.p =='logoff'>
    <cfset session.user = stateFunctions.obtainUser() />
    <cfset p="carousel" />
</cfif>