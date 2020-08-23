let resizeMain = () => {
	let main = document.getElementById('main');
	let column = parseInt(main.clientWidth / 240);
	main.setAttribute('style', `column-count: ${column};`);
}

window.addEventListener('resize', resizeMain, false);

resizeMain();
