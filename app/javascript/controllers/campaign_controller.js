import ClassicEditor from "../ckeditor";

const CampaignController = () => {
  const campaignHtmlPart = document.getElementById("campaignHtmlPart");
  if (campaignHtmlPart) {
    ClassicEditor.create(campaignHtmlPart, {
    // https://ckeditor.com/docs/ckeditor5/latest/features/toolbar/toolbar.html#extended-toolbar-configuration-format
    toolbar: {
      items: [
        'findAndReplace', 'selectAll', 'showBlocks', '|',
        'heading', '|', 'bold', 'italic', 'strikethrough', 'underline', 'code', 'subscript', 'removeFormat', '|',
        'bulletedList', 'numberedList', 'todoList', '|',
        'outdent', 'indent', '|',
        'undo', 'redo',
        '-',
        'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
        'alignment', '|',
        'link', 'insertImage', 'blockQuote', 'insertTable', 'mediaEmbed', 'codeBlock', 'htmlEmbed', '|',
        'specialCharacters', 'horizontalLine', 'pageBreak', '|',
        '|',
        'sourceEditing'
      ],
      shouldNotGroupWhenFull: true
    },
    // Changing the language of the interface requires loading the language file using the <script> tag.
    list: {
      properties: {
        styles: true,
        startIndex: true,
        reversed: true
      }
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/headings.html#configuration
    heading: {
      options: [
        {model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
        {model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
        {model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
        {model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
        {model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
        {model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
        {model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
      ]
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/editor-placeholder.html#using-the-editor-configuration
    placeholder: 'Please type your content',
    // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-family-feature
    fontFamily: {
      options: [
        'default',
        'Arial, Helvetica, sans-serif',
        'Courier New, Courier, monospace',
        'Georgia, serif',
        'Lucida Sans Unicode, Lucida Grande, sans-serif',
        'Tahoma, Geneva, sans-serif',
        'Times New Roman, Times, serif',
        'Trebuchet MS, Helvetica, sans-serif',
        'Verdana, Geneva, sans-serif'
      ],
      supportAllValues: true
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/font.html#configuring-the-font-size-feature
    fontSize: {
      options: [ 10, 12, 14, 'default', 18, 20, 22 ],
      supportAllValues: true
    },
    // Be careful with the setting below. It instructs CKEditor to accept ALL HTML markup.
    // https://ckeditor.com/docs/ckeditor5/latest/features/general-html-support.html#enabling-all-html-features
    htmlSupport: {
      allow: [
        {
          name: /.*/,
          attributes: true,
          classes: true,
          styles: true
        }
      ]
    },
    // Be careful with enabling previews
    // https://ckeditor.com/docs/ckeditor5/latest/features/html-embed.html#content-previews
    htmlEmbed: {
      showPreviews: true
    },
    // https://ckeditor.com/docs/ckeditor5/latest/features/link.html#custom-link-attributes-decorators
    link: {
      decorators: {
        addTargetToExternalLinks: true,
        defaultProtocol: 'https://',
        toggleDownloadable: {
          mode: 'manual',
          label: 'Downloadable',
          attributes: {
            download: 'file'
          }
        }
      }
    },
  }).then( editor => {
    window.ctEditor = editor;
  });
} 

  $(document).on('click', '.contentImageBoxMini', function(e) {
    e.stopPropagation();
    e.stopImmediatePropagation();
    var src = e.target.src
    var img = "<img src='"+  src +"'>"
    const viewFragment = ctEditor.data.processor.toView(img);
    const modelFragment = ctEditor.data.toModel(viewFragment); 
    ctEditor.model.insertContent(modelFragment, ctEditor.model.document.selection);
  });

  $("#content-template-search").select2({
    placeholder: "Search for a content template",
    allowClear: true,
    dropdownParent: null
  });

  // for displaying content on CkEditor 
  $("#content-template-search").on("select2:select", function(e) {
    var selectedTemplate = e.params.data;
    var accountId = e.target.getAttribute('data_account_id')
    if (selectedTemplate) {
      $.ajax({
        url: '/accounts/' + accountId + '/campaigns/new',
        dataType: "json",
        delay: 250,
        data: {
          search_term: selectedTemplate.id,
        },
        success: function(data) {
          if (data) {
            // Clear the CkEditor's previous data
            ctEditor.setData('');
            const viewFragment = ctEditor.data.processor.toView(data.html_part);
            const modelFragment = ctEditor.data.toModel(viewFragment);
            const selection = ctEditor.model.document.selection;
            const selectedData = data.html_part;
            $(".selected-value-container").html(selectedData);
            if (selection.isCollapsed) {
              // Insert the content at the current position
              ctEditor.model.insertContent(modelFragment, selection);
            } else {
              // Replace the selected content with the new content
              ctEditor.model.replaceRange(modelFragment, selection);
            }
          }
        },
      });
    }
  });

  // Clear the Data
  $("#content-template-search").on("select2:clear", function() {
    ctEditor.setData('');
    $(".selected-value-container").html("Please select a content template!!")
  });

  var initialContentTemplateId = $("#content-template-search").attr("data-content-template-id");
  if (initialContentTemplateId) {
    $("#content-template-search").val(initialContentTemplateId).trigger("change");
  }

  $(document).on("click", ".contentDelete", function(e) {
    e.preventDefault();
    var accountId = $(this).data('account-id');
    var contentId = $(this).data('content-id');
    var deletePath = "/accounts/" + accountId + "/campaigns/" + contentId;
    $("#ciFolderdeleteConfirmationLink").attr("href", deletePath);
  });

  function setFolderId() {
    const folderIdInput = document.getElementById('FolderIdSetCampaign');
    const folderId = folderIdInput.value;
    localStorage.setItem('folder_id', folderId);
  }
  
  function getFolderId() {
    const storedFolderId = localStorage.getItem('folder_id');
    $("#FolderIdSetCampaign").val(storedFolderId);
  }

  if (document.getElementById('FolderIdSetCampaign') !== null && !document.getElementById('FolderIdSetCampaign').value == "") { 
    setFolderId();
  }

  getFolderId();

}

export { CampaignController };
