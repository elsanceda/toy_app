document.addEventListener("turbo:load", function() {
    const carousel = document.getElementById('toy-carousel')
    const items = carousel.querySelectorAll('.item');
    const dots = document.querySelectorAll('.carousel-indicators li');
    let currentItem = 0;
    let isActive = true;

    function setCurrentItem(index) {
        currentItem = (index + items.length) % items.length;
    }

    function goToItem(n) {
    	if (n < currentItem) {
    		hideItem('to-right');
    		currentItem = n;
    		showItem('from-left');
    	} else {
    		hideItem('to-left');
    		currentItem = n;
    		showItem('from-right');
    	}
    }

    function hideItem(direction) {
        isActive = false;
        items[currentItem].classList.add(direction);
        dots[currentItem].classList.remove('active');
        items[currentItem].addEventListener('animationend', function() {
            this.classList.remove('active', direction);
        });
    }

    function showItem(direction) {
        items[currentItem].classList.add('next', direction);
        dots[currentItem].classList.add('active');
        items[currentItem].addEventListener('animationend', function() {
            this.classList.remove('next', direction);
            this.classList.add('active');
            isActive = true;
        });
    }

    document.getElementById('carouselPrev').addEventListener('click', function(e) {
        e.preventDefault()
        if (isActive) {
            hideItem('to-right');
            setCurrentItem(currentItem - 1);
            showItem('from-left');
        }
    });

    document.getElementById('carouselNext').addEventListener('click', function(e) {
        e.preventDefault()
        if (isActive) {
            hideItem('to-left');
            setCurrentItem(currentItem + 1);
            showItem('from-right');
        }
    });

    document.querySelector('.carousel-indicators').addEventListener('click', function(e) {
    	let target = [].slice.call(e.target.parentNode.children).indexOf(e.target);
    	if (target !== currentItem && target < dots.length) {
    		goToItem(target);
    	}
    });
});
