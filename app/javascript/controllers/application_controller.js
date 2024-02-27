import * as bootstrap from "bootstrap";
import Croppie from "croppie";
import ClassicEditor from "../ckeditor";

const ApplicationController = () => {
  ClassicEditor;
  // Initiate tooltips and popover
  let popoverTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="popover"]')
  );
  let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl);
  });

  var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // Sidebar toggle
  var sidebar_btn = document.querySelector(".toggle-sidebar-btn");
  if (sidebar_btn !== null) {
    sidebar_btn.onclick = function () {
      document.querySelector("body").classList.toggle("toggle-sidebar");
    };
  }

  // Search bar toggle
  var search_bar = document.querySelector(".search-bar-toggle");
  if (search_bar !== null) {
    search_bar.onclick = function () {
      document.querySelector(".search-bar").classList.toggle("search-bar-show");
    };
  }

  // Initiate Bootstrap validation check
  (function () {
    "use strict";
    var forms = document.querySelectorAll(".needs-validation");
    Array.prototype.slice.call(forms).forEach(function (form) {
      form.addEventListener(
        "submit",
        function (event) {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add("was-validated");
        },
        false
      );
    });
  })();

  // Easy selector helper function
  const select = (el, all = false) => {
    el = el.trim();
    if (all) {
      return [...document.querySelectorAll(el)];
    } else {
      return document.querySelector(el);
    }
  };

  // Easy event listener function
  const on = (type, el, listener, all = false) => {
    if (all) {
      select(el, all).forEach((e) => e.addEventListener(type, listener));
    } else {
      select(el, all).addEventListener(type, listener);
    }
  };

  // Toggle .header-scrolled class to #header when page is scrolled
  let selectHeader = document.querySelector("#header");
  if (selectHeader) {
    const headerScrolled = () => {
      if (window.scrollY > 100) {
        selectHeader.classList.add("header-scrolled");
      } else {
        selectHeader.classList.remove("header-scrolled");
      }
    };
    window.addEventListener("load", headerScrolled);
    onscroll(document, headerScrolled);
  }

  // Back to top button
  let backtotop = document.querySelector(".back-to-top");
  if (backtotop) {
    const toggleBacktotop = () => {
      if (window.scrollY > 100) {
        backtotop.classList.add("active");
      } else {
        backtotop.classList.remove("active");
      }
    };
    window.addEventListener("load", toggleBacktotop);
    onscroll(document, toggleBacktotop);
  }

  // Easy on scroll event listener
  function onscroll(el, listener) {
    el.addEventListener("scroll", listener);
  }

  // Easy on scroll event listener
  let navbarlinks = document.querySelector(".scrollto");
  const navbarlinksActive = () => {
    let position = window.scrollY + 200;
    if (navbarlinks !== null) {
      navbarlinks.forEach((navbarlink) => {
        if (!navbarlink.hash) return;
        let section = document.querySelector(navbarlink.hash);
        if (!section) return;
        if (
          position >= section.offsetTop &&
          position <= section.offsetTop + section.offsetHeight
        ) {
          navbarlink.classList.add("active");
        } else {
          navbarlink.classList.remove("active");
        }
      });
    }
  };
  window.addEventListener("load", navbarlinksActive);
  onscroll(document, navbarlinksActive);

  // UI validation for multi buttons
  if ($('.treeRow')[0] !== undefined) {
    if ($(".multiButton")[0] !== undefined) {
      setTimeout(function() {
        $('.treeRow')[0].click();
      }, 800);
    } else {
      if ($(".multiButton")[0] !== undefined) { 
        $(".multiButton")[0].className = "multiButton disabled";
      }
      $("#selectFolderWarning").css("display", "block");
    }
  }
};

export { ApplicationController };
