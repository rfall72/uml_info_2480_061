component {
    function obtainSearchResults(searchme, genre){
        if(searchme.len()!=0){
        var qs = new query(datasource=application.dsource);
        qs.setSql("SELECT * 
                    FROM books inner join publisher on books.publisherID=publisher.publisherID 
                    WHERE title like '%#trim(searchme)#%'
                    OR ISBN13 like '%#trim(searchme)#%'");
        qs.addParam(
                name="searchme",
                value='%#trim(searchme)#%'
            );
        return qs.execute().getResult();
        }else if(genre.len()!=0){
            var qs = new query(datasource=application.dsource);
            qs.setSql("
                SELECT * FROM books
                INNER JOIN genreToBooks on books.ISBN13=genreToBooks.ISBN13
                INNER JOIN publisher on books.publisherID=publisher.publisherID
                WHERE genreID=:genre"
            );
            qs.addParam(
                name="genre",
                value=trim(arguments.genre)
            );
            return qs.execute().getResult();
        }
    }

    function obtainGenre(){
        var qs = new query(datasource=application.dsource);
        qs.setSql(
            "SELECT DISTINCT genres.genreID, genreName
            FROM genreToBooks inner join genres on genres.genreID=genreToBooks.genreID
            ORDER BY genreName"
        );

        return qs.execute().getResult();
    }

    function resultsHeader(searchme){
        if(searchme.len()!=0){

        var qs = searchme;
        return qs;

        }
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
