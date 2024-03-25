
<cfparam name="newAccountMessage" default="" />
<cfparam name="LoginMessage" default="" />


<script type="text/javascript">
    function validateNewAccount(){
        let originalPassword= document.getElementById('password').value;
        let confirmPassword= document.getElementById('confirmPassword').value;
        
        if(originalPassword !=='' && originalPassword === confirmPassword){
            document.getElementById('submitNewAccountForm').click();
            document.getElementById('newAccountMessage').innerHTML="";
        }else{
            document.getElementById('newAccountMessage').innerHTML="Enter matching password";
        }
    }
</script>
    
<div class="row">
 <div class="col-6">
    <cfoutput>#loginForm()#</cfoutput>
 </div>
 <div class="col-6">
    <cfoutput>#newAccountForm()#</cfoutput>
 </div>

</div>


<cffunction name="newAccountForm">
    <h2> Create New Account </h2>
    <cfoutput>   

        <div id="newAccountMessage">
        #newAccountMessage#   
        </div>

        <form action="#cgi.script_name#?p=login" method="post">
            <div class="form-floating mb-3">
                <input required type="text" id="firstName" name="firstName" class="form-control" placeholder="First Name" />
                <label for="firstName">First Name</label>
            </div>

            <div class="form-floating mb-3">
                <input required type="text" id="lastName" name="lastName" class="form-control" placeholder="Last Name" />
                <label for="lastName">Last Name</label>
            </div>

            <div class="form-floating mb-3">
                <input required type="text" id="title" name="title" class="form-control" placeholder="title" />
                <label for="title">Title</label>
            </div>

            <div class="form-floating mb-3">
                <input required type="email" id="email" name="email" class="form-control" placeholder="email" />
                <label for="email">email</label>
            </div>

            <div class="form-floating mb-3">
                <input required type="password" id="password" name="password" class="form-control" placeholder="password" />
                <label for="password">password</label>
            </div>

            <div class="form-floating mb-3">
                <input required type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="confirmPassword" />
                <label for="confirmPassword">Confirm Password</label>
            </div>

        <div class="form-float mb-3">
            <button type="button" class="btn btn-warning" onclick="validateNewAccount()">Create Account</button>
            <input type="submit" id="submitNewAccountForm" style="display:none" />
        </div>
     
        </form>
    </cfoutput>
</cffunction>



<cffunction name="loginForm">
    <h2> Login </h2>
    <cfoutput> 
        <div id="LoginMessage">
            #LoginMessage#
        </div>
        
        <form action="#cgi.script_name#?p=login" method="post" enctype="multipart/form-data">
            <div class="form-floating mb-3">
                <input required type="email" id="loginemail" name="loginemail" class="form-control" placeholder="login email" />
                <label for="loginemail">email address</label>
            </div>

            <div class="form-floating mb-3">
                <input required type="password" id="loginpass" name="loginpass" class="form-control" placeholder="Login password" />
                <label for="loginpass">password</label>
            </div>

            <div class="form-float mb-3">
            <button id="loginButton" type="submit" class="btn btn-primary">login</button>
            </div>

        </form>
    </cfoutput>
</cffunction>
