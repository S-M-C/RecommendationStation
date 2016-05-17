window.newModal = function (path,title,height,width) {
    ShopifyApp.Modal.open({
        src: path,
        title: title,
        height: height,
        width: width,
        buttons : {
            primary: {
                label : "Canel",
                callback: function(message){
                    ShopifyApp.Modal.close("ok")
                }
            }
        }
    })
}