window.addEventListener('scroll', function(event) {
    var depth,  i, layer, layers, len, movement, topDistance, translate3d;
    topDistance = this.pageYOffset;
    layers = this.document.querySelectorAll("[data-type='parallax']");
    len = layers.length
    for (i = 0; i < len; i++) {
        layer = layers[i];
        depth = layer.getAttribute('data-depth');
        movement = -(topDistance * depth);
        translate3d = 'translate3d(0, ' + movement + 'px, 0)';
        layer.style['-webkit-transform'] = translate3d;
        layer.style['-moz-transform'] = translate3d;
        layer.style['-ms-transform'] = translate3d;
        layer.style['-o-transform'] = translate3d;
        layer.style.transform = translate3d;
    }
});