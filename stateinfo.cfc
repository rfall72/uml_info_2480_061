component{
    function obtainUser() {
        return {

        "isLoggedIn" = false,
        "firstName"= "",
        "lastName"= "",
        "email"="",
        "acctNumber"="",
        "isAdmin"=0


        };
    }

    function emailisUnique(required string email){
        var qs = new query(datasource=application.dsource);
        qs.setSql("SELECT * FROM people WHERE email=:email");
        qs.addParam(name="email",value=arguments.email);
        return qs.execute().getResult().recordcount==0;
    }

    function processNewAccount(formData){
        var retme = {success:false,message:""}
        if(emailisUnique(formData.email)){
            var newid = createuuid();
            if(addPassword(newid, formData.password)){
                addAccount(newid, formData.firstName, formData.lastName, formData.email)
                retme.success=true;
                retme.message="Account made. Go to login!";
            };

        }else{
                retme.message="That email is already in our system. Please login";
        };
        return retme;
    }
    function addPassword(id, password){
        try{
            var qs = new query(datasource=application.dsource);
            qs. setSql("INSERT into password(personID, password)
            VAULES (:personID, :password) ");
            qs.addParam(
                name="personID",
                value = arguments.id
            );
            qs.addParam(
                name="password",
                value=hash(arguments.password,"SHA-512")
            );
            qs.execute();
            return true;
        }
        catch(ary err){
            return false;
        }
    }

    function addAccount(required string id, 
                        required string firstName,
                        required string lastName,
                        required string email,
                        numeric isAdmin=0){
            var qs= new query(datasource=application.dsource);
            qs. setSql("INSERT into People(personID,firstName, lastName, email, isAdmin)
            VAULES (:personID, :firstName, :lastName, :email, :isAdmin)");
            qs.addParam(
                name="personID",
                value=arguments.id
            );
            qs.addParam(
                name="firstName",
                value=arguments.firstName
            );
            qs.addParam(
                name="lastName",
                value=arguments.lastName
            );
            qs.addParam(
                name="email",
                value=arguments.email
            );
            qs.addParam(
                name="isAdmin",
                value=arguments.isAdmin
            );
            qs.execute();
        }

        function logMeIn(username, password) {
        var qs= new query(datasource=application.dsource);
        qs. setSql("SELECT *
                    FROM People
                        INNER JOIN password on People.personID=password.personID
                    WHERE email=:email AND password=:password");
            qs.addParam(
                name="email",
                value=arguments.username
            );
            qs.addParam(
                name="password",
                value=hash(form.loginpass,"SHA-512")
            );
            return qs.execute().getResult();
    }

}

