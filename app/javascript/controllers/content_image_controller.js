const ContentImageController = () => {
  
  $("#addNewFileInput").on('click', function() {
    var f = $('.contentImageFormTable tr').first();
    var lastRow = $(".contentImageFormTable tr:last")
    lastRow.prev().after("<tr>"+ f.html() +"</tr>");
    lastRow.prev()[0].children[1].className = '';
    lastRow.prev()[0].children[1].children[1].textContent = 'Please choose image to uplad.'
    recountImageLabels();
  });

  $(document).on('click', '.contentImageRemove', function(e) {
    e.stopPropagation();
    e.stopImmediatePropagation();
    if($('.contentImageFormTable tr').length > 2) { 
      e.target.closest('tr').remove();
      recountImageLabels(); 
    }
  });

  function recountImageLabels(){
    var i = 1;
    $('.contentImageFormTable tr label').each(function(){
      $(this).html("Image "+ i++ +".");
    });
  }

  $("#uploadImgButton").on('click', function(){
    var errors = 1
    $('.contentImageField').each(function(){
      var parent = this.parentElement
      if (this.value === '') {
        parent.className = 'ci-error';
      } else {
        fileValidationCheck(this)
      }
      errors = $(".ci-error").length
    });
    if (errors === 0) {
      $("#submitUploadImgButton").click();
    }
  })

  $(document).on('change', '.contentImageField', function(e) {
    fileValidationCheck(e)
  });

  function fileValidationCheck(element) {
    e = element.target === undefined ? element : element.target
    const file = e.files[0];
    const  fileType = file['type'];
    const validImageTypes = ['image/gif', 'image/jpeg', 'image/png'];
    var parent = e.parentElement
    var nextEle = e.nextElementSibling
    if (validImageTypes.includes(fileType)) {
      parent.className = '';
      nextEle.textContent = 'Please choose image to uplad.';
    } else {
      parent.className = 'ci-error';
      nextEle.textContent = 'Please choose image file ex. formate jpeg, png, gif.'
    }
  }

  $(document).on('click', '.contentFolderDelete', function(e) {
    e.stopPropagation();
    e.stopImmediatePropagation();
    var objId = e.target.getAttribute('data-id')
    var accountId = e.target.getAttribute('data-account-id')
    var object_class = e.target.getAttribute('data-object-class')
    var href = "/accounts/" + accountId + "/folders/" + objId + "?object_class=" + object_class;
    document.querySelector("#ciFolderdeleteConfirmationLink").href = href
  });

  $(document).on('click', '.contentImageDelete', function(e) {
    e.stopPropagation();
    e.stopImmediatePropagation();
    var objId = e.target.getAttribute('data-id')
    var accountId = e.target.getAttribute('data-account-id')
    var folder_id = e.target.getAttribute('data-folder-id')
    var folder_depth = document.querySelector('.foldersData').getAttribute('data-depth')
    var href = "/accounts/" + accountId + "/content_images/" + objId + "?folder_depth=" + folder_depth + "&folder_id=" + folder_id;
    document.querySelector("#ciFolderdeleteConfirmationLink").href = href
  });

}

export { ContentImageController };