var modal = document.getElementById("galleryModal");
var span = document.getElementsByClassName("close")[0];
var images = document.querySelectorAll(".gallery-img img");
var originalParent = null;
var currentImage = null;

images.forEach(function (img) {
  img.style.cursor = "pointer";
  img.onclick = function (e) {
    e.preventDefault();
    modal.style.display = "block";
    // Move the image to the modal
    originalParent = img.parentNode;
    currentImage = img;
    modal.appendChild(img);
  };
});

span.onclick = function () {
  modal.style.display = "none";
  // Move the image back to its original parent
  if (originalParent && currentImage) {
    originalParent.appendChild(currentImage);
  }
};
