/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//Slider
document.addEventListener("DOMContentLoaded", function () {
    const images = document.querySelectorAll(".slider-content-top img");
    const items = document.querySelectorAll(".slider-content-bottom li");

    items.forEach((item) => {
        item.addEventListener("click", function () {
            // Remove active class from all images and items
            images.forEach((img) => img.classList.remove("active"));
            items.forEach((it) => it.classList.remove("active"));

            // Add active class to the clicked item and corresponding image
            const imgId = this.getAttribute("data-img");
            document.getElementById(imgId).classList.add("active");
            this.classList.add("active");
        });
    });
});

//Slider sale
const rightbtn = document.querySelector('.uil-angle-right-b');
const leftbtn = document.querySelector('.uil-angle-left-b');
const divNumber = document.querySelectorAll('.slider-product-one-content-items');
let index = 0;
//console.log(rightbtn);
//console.log(leftbtn);

rightbtn.addEventListener("click", function () {
    index = index + 1;
    if (index > divNumber.length - 1) {
        index = 0;
    }
    document.querySelector(".slider-product-one-content-items-container").style.right = index * 100 + "%";
});

leftbtn.addEventListener("click", function () {
    index = index - 1;
    if (index <= 0) {
        index = divNumber.length - 1;
    }
    document.querySelector(".slider-product-one-content-items-container").style.right = index * 100 + "%";
});




