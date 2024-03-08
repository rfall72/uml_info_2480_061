
component{
    function processForms(required struct formData){
        if(formData.keyExists("ISBN13") && formData.ISBN13.len()==13 && formData.title.len() >0) {

            if(formdata.keyExists("uploadImage") && formData.uploadImage.len()>0){
                    formData.image = UploadBookCover();
                }

            var qs = new query(datasource=application.dsource);
            qs.setSql("
                IF NOT EXISTS(SELECT * FROM books WHERE ISBN13=:ISBN13)

                INSERT into books(ISBN13,title) VALUES(:ISBN13,:title);

                UPDATE books SET
                    title=:title,
                    weight=:weight,
                    year=:year,
                    isbn=:isbn,
                    pages=:pages,
                    publisherID=:publisherID,
                    image=:image,
                    description=:description
                    WHERE ISBN13=:ISBN13
                ");
            qs.addParam(
                name="ISBN13",
                cfsqltype="CF_SQL_NVARCHAR",
                value=formData.ISBN13,
                null=formData.ISBN13.len()!=13
            );
            qs.addParam(
                name="title",
                cfsqltype="CF_SQL_NVARCHAR",
                value=formData.title,
                null=formData.title.len()==0
            );

            qs.addParam(
                name="weight",
                cfsqltype="CF_SQL_NUMERIC",
                value=formData.weight
            );

            qs.addParam(
                name="year",
                cfsqltype="CF_SQL_NUMERIC",
                value=formData.year
            );

            qs.addParam(
                name="isbn",
                cfsqltype="CF_SQL_NVARCHAR",
                value=formData.isbn
            );

            qs.addParam(
                name="pages",
                cfsqltype="CF_SQL_NUMERIC",
                value=formData.pages
            );

            qs.addParam(
                name="publisherID",
                cfsqltype="CF_SQL_NVARCHAR",
                value=trim(formData.publisherID),
                null=trim(formData.publisherID).len()!=35
            );

            qs.addParam(
                name="image",
                cfsqltype="CF_SQL_NVARCHAR",
                value=trim(formData.image),
                null=trim(formData.image).len() == 0
            );

            qs.addParam(
                name="description",
                cfsqltype="CF_SQL_NVARCHAR",
                value=trim(formData.description),
                null=trim(formData.publisherID).len()==0
            );

            qs.execute();
        }
    }

        function sideNavBooks(qterm){
            if(qterm.len()==0){
                return queryNew("title");
            } else {
            var ql = new query(datasource=application.dsource);
                ql.setSql("SELECT * FROM books WHERE title like :qterm ORDER BY title");
                ql.addParam(
                    name="qterm",
                    value="%#qterm#%"
                );
                return ql.execute().getResult();
            }
        }

    function allPublishers(){
        var qp = new query(datasource=application.dsource);
        qp.setSql("SELECT * FROM publisher ORDER BY name");
        return qp.execute().getResult();
    }

    function bookDetails(ISBN13){
        var qb = new query(datasource=application.dsource);
        qb.setSql("SELECT * FROM books WHERE ISBN13=:ISBN13");
            qb.addParam(
                name="ISBN13",
                cfsqltype="CF_SQL_NVARCHAR",
                value=trim(arguments.ISBN13)
            );
        return qb.execute().getResult();    
    }

    function UploadBookCover(){
        var imageData = fileUpload(expandPath("../images/"),"uploadImage","*","makeUnique");
        return imageData.serverFile;
    }
}
