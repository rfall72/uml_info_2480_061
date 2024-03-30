<nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">
                <img src="images/rdb.png" alt="Read Dees Books Logo"/>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <cfoutput>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=content&contentID=2703A37C-165C-43BC-85DCC7840A37B7DA">Store Information</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=content&contentID=DAE9D05F-5708-4F81-B16AC709B7977284">Highlighted Favorites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=content&contentID=09649DE5-8265-4DAE-847CA8FC966A464B">Events</a>
                    </li>

            
                <cfif session.user.isAdmin>
                        <li class="nav-item">
                            <a class="nav-link" href="management/index.cfm" target="_blank">Management Page</a>
                        </li>
                    </cfif>
                </cfoutput>        
                    
                </ul>

                

                <cfoutput>
                <form class="d-flex" action="#cgi.script_name#?p=details" method="post">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="searchme">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
                
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">                        
                            <cfif session.user.isLoggedIn>
                                <li class="nav-item">
                                    <span class="nav-link">Welcome #session.user.firstName#</span>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#cgi.script_name#?p=logoff">Logout</a>
                                </li>
                            <cfelse>
                                <li class="nav-item">
                                    <a class="nav-link" href="#cgi.script_name#?p=login">Login</a>
                                </li>
                            </cfif>
                    </li>
                </ul>
               </cfoutput>  
            </div>
        </nav>