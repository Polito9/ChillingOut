$(document).ready(function() {
    var slides = $('.slide');
    var currentSlide = 0;
    
    setInterval(function() {
        slides.removeClass('active');
        currentSlide = (currentSlide + 1) % slides.length;
        slides.eq(currentSlide).addClass('active');
    }, 3000);
});