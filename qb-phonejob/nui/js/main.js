let ProfitPercent, price, count;

$(document).ready(function () {
    updateVal();

    $("#count").change((e) => {
        updateVal();
    });
       
    function updateVal(){
        count  = $("#count").val();
    
        price = (count/100) * (100-ProfitPercent)
        $("#buyBtn").html(`Buy ${count} Credit (${price}$)`);
    }

    $("#buyBtn").click(function (e) { 
        e.preventDefault();
        phone = $("#phone").val();
        count  = $("#count").val();

        if(phone.length != 10){
            $.post('https://qb-phonejob/notify', JSON.stringify({
                text: "Wrong phone number!"
            }));
            return
        }

        $.post('https://qb-phonejob/payment', JSON.stringify({
            phone: phone,
            credit: count,
            price: price
        }));
        
        console.log(`${phone} Buyed ${count} credit for ${price}$.`);
    });

    $(document).keyup(function(e) {
        if (e.key === "Escape") { // escape key maps to keycode `27`
            $.post('https://qb-phonejob/closeMenu');
       }
    });

    window.addEventListener('message', (event) => {
        let data = event.data
        switch (data.type) {
            case 'open':
                ProfitPercent = data.config["ProfitPercent"];
                MinimumBalance = data.config["MinimumBalance"];
                MaxBalance = data.config["MaxBalance"];

                $("body").css("display", "block");
                break;
            case 'close':
                $("body").css("display", "none");
                break;    
        }
    })
});

