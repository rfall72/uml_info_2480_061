component {
    function obtainSearchResults(){
        var qs = new query(datasource=application.dsource);
        qs.setSql("SELECT * 
                    FROM books inner join publisher on books.publisherID=publisher.publisherID 
                    WHERE title like '%#trim(form.searchme)#%'
                    OR ISBN13 like '%#trim(searchme)#%'");
        qs.addParam(
            name="title"
                );
        return qs.execute().getResult();
    }
}
