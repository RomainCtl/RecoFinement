// small lib to view image in fullscreen
(function () {
  let fullScreenElement = null;

  /* View in fullscreen */
  function openFullscreen(elem) {
    elem.style.cursor = "zoom-out";
    fullScreenElement = elem;

    if (elem.requestFullscreen) {
      elem.requestFullscreen();
    } else if (elem.mozRequestFullScreen) {
      /* Firefox */
      elem.mozRequestFullScreen();
    } else if (elem.webkitRequestFullscreen) {
      /* Chrome, Safari and Opera */
      elem.webkitRequestFullscreen();
    } else if (elem.msRequestFullscreen) {
      /* IE/Edge */
      elem.msRequestFullscreen();
    }
  }

  /* Close fullscreen */
  function closeFullscreen() {
    fullScreenElement.style.cursor = "zoom-in";
    fullScreenElement = null;

    if (document.exitFullscreen) {
      document.exitFullscreen();
    } else if (document.mozCancelFullScreen) {
      /* Firefox */
      document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) {
      /* Chrome, Safari and Opera */
      document.webkitExitFullscreen();
    } else if (document.msExitFullscreen) {
      /* IE/Edge */
      document.msExitFullscreen();
    }
  }

  function toggleFullscreen(elem) {
    if (!fullScreenElement) {
      openFullscreen(elem);
    } else {
      closeFullscreen(elem);
    }
  }

  // when image is clicked, enable or disable fullscreen
  Array.from(document.querySelectorAll(".md-content img")).map((element) => {
    element.onclick = (evt) => {
      toggleFullscreen(evt.srcElement);
    };
  });

  // update image style when escape is pressed
  function exitHandler(evt) {
    if (
      !document.webkitIsFullScreen &&
      !document.mozFullScreen &&
      !document.msFullscreenElement !== null
    ) {
      if (!!fullScreenElement) {
        fullScreenElement.style.cursor = "zoom-in";
        fullScreenElement = null;
      }
    }
  }

  document.addEventListener("fullscreenchange", exitHandler, false);
  document.addEventListener("mozfullscreenchange", exitHandler, false);
  document.addEventListener("MSFullscreenChange", exitHandler, false);
  document.addEventListener("webkitfullscreenchange", exitHandler, false);
})();