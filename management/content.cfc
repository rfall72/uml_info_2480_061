component{

    function allContent(contentID){
        var qs = new query(datasource=application.dsource);
        qs.setSql(
            "SELECT *
            FROM content
            ORDER BY title");

        return qs.execute().getResult();
    }

        function processContent(formData){
            var qs = new query(datasource=application.dsource);
        if(formData.keyExists("contentID")) {
            
            qs.setSql("
                UPDATE content SET
                    title=:title,
                    description=:description
                    WHERE contentID=:contentID
                ");
            qs.addParam(
                name="contentID",
                value=formData.contentID
            );
            }else{
            qs.setSql("
                INSERT into content(title,description)
                VALUES(:title,:description);")
            }
            qs.addParam(
                name="title",
                value=formData.title
            );
            qs.addParam(
                name="description",
                value=trim(formData.description)
            );
            qs.execute();

            }
        


        function obtainArticle(contentID){
        var bg = new query(datasource=application.dsource);
        bg.setSql("SELECT *
                FROM content
                WHERE contentID=:contentID
                ");
        bg.addParam(name="contentID", value=contentID);
        return bg.execute().getResult();
        }

    }
