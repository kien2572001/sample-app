// Prevent uploading of big images.
document.addEventListener("turbo:load", function() {
  document.addEventListener("change", function(event) {
    let image_upload = document.querySelector('#micropost_image');
    const size_in_megabytes = image_upload.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert(i18n.t("microposts.validate.chose_other_image"));
      image_upload.value = "";
    }
  });
});
