$(document).ready ->
    # Make navbar tabs active
    $('a[href="' + this.location.pathname + '"]').parent().addClass('active')
