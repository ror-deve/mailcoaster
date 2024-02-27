import ClassicEditor from "../ckeditor";

const ContentTemplateController = () => {
  const contentTemplateHtmlPart = document.getElementById("contentTemplateHtmlPart");
  if (contentTemplateHtmlPart) {
    ClassicEditor.create(contentTemplateHtmlPart, {
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

  $(document).on('click', '.contentTemplateDelete', function(e) {
    e.preventDefault();
    var accountId = $(this).data('account-id');
    var contentTemplateId = $(this).data('content-template-id');
    var deletePath = '/accounts/' + accountId + '/content_templates/' + contentTemplateId;
    $('#ciFolderdeleteConfirmationLink').attr('href', deletePath);  
  });

  function setFolderId() {
    const folderIdInput = document.getElementById('FolderIdSet');
    const folderId = folderIdInput.value;
    localStorage.setItem('folder_id', folderId);
  }
  function getFolderId() {
    const storedFolderId = localStorage.getItem('folder_id');
    $("#FolderIdSet").val(storedFolderId);
  }
  if (!document.getElementById('FolderIdSet').value == "") { 
    setFolderId();
  }
  getFolderId();

}

export { ContentTemplateController };
