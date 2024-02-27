// Folder tree script - open/close folder tree and expand
const FolderTreeController = () => {
  const row = document.querySelectorAll(".folderTreeRow");
  const expand = document.querySelectorAll('.folder-expand');
  row.forEach((el) => {
    el.addEventListener("click", function (e) {
      e.preventDefault();

      const selected = document.querySelectorAll(".folderSelected");
      selected.forEach((el) => {
        el.classList.remove("folderSelected");
      });

      // set href to folder actions
      if (document.querySelector(".objectDataList") !== null) {
        var selectedFolderId = this.getAttribute("data-id");
        var object_class = document.querySelector(".objectDataList").getAttribute("data-object-class");
        var accountId = this.getAttribute("data-account");
        document.getElementById("newFolder").href =
          "/accounts/" + accountId + "/folders/new?parent_id=" + selectedFolderId + "&object_class=" + object_class;
        document.getElementById("deleteFolder").href =
          "/accounts/" + accountId + "/folders/" + selectedFolderId + "?object_class=" + object_class;
        document.getElementById("editFolder").href =
          "/accounts/" + accountId + "/folders/" + selectedFolderId + "/edit?object_class=" + object_class;

        document.getElementById("folderSection").dataset.folderId = selectedFolderId;
        // select the current folder
        this.classList.toggle("folderSelected");

        // UI validation for multi buttons
        $("#selectFolderWarning").css({ display: "none", transition: "1s" });
        $(".multiButton")[0].className = "multiButton";
      }
    });

    el.addEventListener("dblclick", function (e) {
      e.stopPropagation();
      if (this.getAttribute("data-row-expandable") !== null) {
        this.classList.toggle("folderExpanded");
      }
    });
  });

  expand.forEach((el) => {
    el.addEventListener('click', function () {
      const row = this.parentNode;
      row.classList.toggle('folderExpanded');
      // change folder image after toggle
      if (row.children[1].src.indexOf("-open") != -1) {
        row.children[1].src = "/assets/folder.png";
        row.children[0].className = "folder-expand bi bi-caret-right-fill";
      } else {
        row.children[1].src = "/assets/folder-open.png";
        row.children[0].className = "folder-expand bi bi-caret-down-fill";
      }
    });
  });

  row.forEach((el) => {
    el.addEventListener("contextmenu", function (e) {
      e.preventDefault();
      return false;
    });
  });

  // Grid or list selection
  $('#sortUp').on('click', function() {
    $('#sortDown').removeClass('active')
    $(this).addClass('active')
  });

  $('#sortDown').on('click', function() {
    $('#sortUp').removeClass('active')
    $(this).addClass('active')
  });
};

export { FolderTreeController };
