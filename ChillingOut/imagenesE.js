// Obtener referencias a los elementos relevantes del carrusel
var slides = document.querySelectorAll('.slide');
var slideRadioButtons = document.querySelectorAll('input[name="slider"]');
var currentSlideIndex = 0;

// Arreglo de nombres de imágenes aleatorias
var randomImages = [
  'images/post1.png',
  'images/post2.png',
  'images/post3.png',
  'images/post4.png',
  'images/post5.png',
  'images/post6.png',
  'images/post7.png',
  'images/post8.png',
  'images/post9.png',
  'images/post10.png',
  'images/post11.png',
  'images/post12.png',
  'images/post13.png'
];


// Función para obtener un índice aleatorio
function getRandomIndex(max) {
  return Math.floor(Math.random() * max);
}
var imagesCopy = randomImages.slice();
// Función para mostrar imágenes aleatorias en el slider
function showRandomImages() {
    var imagesCopy = randomImages.slice();
    for (var i = 0;  i<3; i++){
        var slide1 = slides[i].querySelector('img');
        // Obtén indices aleatorios
        var index1 = getRandomIndex(imagesCopy.length);
        var imageSrc1 = imagesCopy[index1];
        slide1.src = imageSrc1;
        imagesCopy.splice(index1, 1);
    }
}
showRandomImages();
// Función para cambiar al siguiente slide
function nextSlide() {
  // Ocultar el slide actual
  slides[currentSlideIndex].classList.remove('active');
  slideRadioButtons[currentSlideIndex].checked = false;

  // Calcular el índice del siguiente slide
  currentSlideIndex = (currentSlideIndex + 1) % slides.length;

  // Mostrar el siguiente slide
  slides[currentSlideIndex].classList.add('active');
  slideRadioButtons[currentSlideIndex].checked = true;
}

// Cambiar la imagen del slide actual con una imagen aleatoria de tu carpeta "random-images"
function changeSlideImage() {
  var currentSlideImage = slides[currentSlideIndex].querySelector('img');
  var randomImageIndex;
  do {
    randomImageIndex = Math.floor(Math.random() * randomImages.length);
  } while (randomImages[randomImageIndex] === currentSlideImage.src);
  var imageUrl = randomImages[randomImageIndex];
  currentSlideImage.src = imageUrl;
}

// Cambiar automáticamente el slide cada día (86400000 ms = 24 horas)
setInterval(function () {
  nextSlide();
  changeSlideImage();
}, 60000);

