function add_to_cart(pid, pname, price) {
    let cart = localStorage.getItem("cart");
    if (cart == null)
    {
//     no cart  
        let products = [];
        let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        //console.log("product added for the first time");
        showToast("item is added to cart");

    } else
    {
//     already present   

        let pcart = JSON.parse(cart);

        let oldProduct = pcart.find((item) => item.productId == pid);
        if (oldProduct)
        {
//            increase quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;
            pcart.map((item) => {
                if (item.productId == oldProduct.productId) {
                    item.productQuantity = oldProduct.productQuantity;
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart));
            //console.log("Product quantity is increased");
            showToast(oldProduct.productName + " quantity is increased");

        } else
        {
//            add product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price};
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            //console.log("product is added");
            showToast("product is added to cart");
        }
    }
    updateCart();


}


//update cart

function updateCart()
{
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart === null || cart.length === 0)
    {
        console.log("cart is empty");
        $(".cart-items").html("( 0 )");
        $(".card-body1").html("<h3>Cart does not have any items </h3>");
        $(".checkout-btn").addClass('disabled');
    } else {
        console.log(cart);
        $(".cart-items").html(`( ${cart.length})`);

        let table = `
            <table class='table'>
                <thead class='thread-light'>
                    <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th>
        
                    </tr>
                
                </thead>
        `;

        let totalPrice = 0;
        cart.map((item) => {

            table += `
                <tr>
                    <td>${item.productName}</td>
                    <td>${item.productPrice}</td>
                    <td>${item.productQuantity}</td>
                    <td>${item.productQuantity * item.productPrice}</td>
                    <td> <button onclick='deleteItemFromCart(${item.productId})' class='btn-danger btn-sm'>Remove </button></td>

                </tr>
`
            totalPrice += item.productPrice * item.productQuantity;

        })


        table = table + `
        <tr><td colspan='5' class="text-right font-weight-bold m-5">Total Price : ${totalPrice}</td></tr>
        </table>`
        $(".card-body1").html(table);
        $(".checkout-btn").removeClass('disabled');
    }
}


function deleteItemFromCart(pid) {
    let cart = JSON.parse(localStorage.getItem("cart"));

    let newCart = cart.filter((item) => item.productId != pid)
    localStorage.setItem('cart', JSON.stringify(newCart))

    updateCart();
    showToast("item is removed to cart");
}

$(document).ready(function () {
    updateCart();
})

function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 2000);
}

function goToCheckout(){
    window.location="checkout.jsp";
    
}

function continueShopping(){
    window.location="index.jsp";
    
}

