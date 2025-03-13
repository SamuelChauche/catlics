// Tableau contenant vos nouvelles URLs de GIFs psychédéliques et d'images
const psychedelicCatImages = [
    "https://c.tenor.com/1fEFQIeJQBwAAAAd/tenor.gif",
    "https://m.media-amazon.com/images/I/91MIYHIURPL._UF1000,1000_QL80_.jpg",
    "https://i1.sndcdn.com/artworks-000529921335-p1ky9w-t500x500.jpg",
    "https://res.cloudinary.com/teepublic/image/private/s--1E4gyYew--/t_Resized%20Artwork/c_fit,g_north_west,h_954,w_954/co_000000,e_outline:48/co_000000,e_outline:inner_fill:48/co_ffffff,e_outline:48/co_ffffff,e_outline:inner_fill:48/co_bbbbbb,e_outline:3:1000/c_mpad,g_center,h_1260,w_1260/b_rgb:eeeeee/c_limit,f_auto,h_630,q_auto:good:420,w_630/v1579066430/production/designs/7578882_1.jpg",
    "https://i.scdn.co/image/ab67616d0000b273f1fa7815ac735b96f0108251",
    "https://steamuserimages-a.akamaihd.net/ugc/842581961522615790/2F2EC0D5DFB9F0C8EC970E852B14F853F746C765/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false",
    "https://masterpiecer-images.s3.yandex.net/60061226a91d47c:upscaled",
    "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/25530c1b-5c89-4c85-8b65-8602af58c383/dgtnwaa-0fd7a094-cd6a-4f1e-b26b-a1db22095cc6.png/v1/fill/w_1920,h_1920,q_80,strp/lsd_vision___cats__6__by_punkerlazar_dgtnwaa-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI1NTMwYzFiLTVjODktNGM4NS04YjY1LTg2MDJhZjU4YzM4M1wvZGd0bndhYS0wZmQ3YTA5NC1jZDZhLTRmMWUtYjI2Yi1hMWRiMjIwOTVjYzYucG5nIiwiaGVpZ2h0IjoiPD0xOTIwIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uud2F0ZXJtYXJrIl0sIndtayI6eyJwYXRoIjoiXC93bVwvMjU1MzBjMWItNWM4OS00Yzg1LThiNjUtODYwMmFmNThjMzgzXC9wdW5rZXJsYXphci00LnBuZyIsIm9wYWNpdHkiOjk1LCJwcm9wb3J0aW9ucyI6MC40NSwiZ3Jhdml0eSI6ImNlbnRlciJ9fQ.2zkKB-hAdmJct_inWW1RkTIIrKdkK1-IhU6e3s82slY",
    "https://cdn.drawception.com/images/panels/2017/11-22/HgNQmHkBp5-1.png",
    "https://c.tenor.com/zbDHXQ60jMIAAAAd/tenor.gif",
    "https://cdn-images.dzcdn.net/images/cover/26417bccc1ab72be71dbb51c086ac778/0x1900-000000-80-0-0.jpg",
    "https://c.tenor.com/vhh_3S0i9C0AAAAd/tenor.gif",
    "https://i.scdn.co/image/ab67616d00001e028f5bc6abdbb6316f3b73d4c1",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSundpy1iMaEcVwHLXOMnKLU5wyap8v_aEYyZIGyP3rHSy0KNBwta-nyVtDD-cqOQ6xYpA&usqp=CAU",
    "https://c8.alamy.com/comp/2DHH05W/l-wains-psychedelic-cat-2DHH05W.jpg",
    "https://i1.sndcdn.com/avatars-000118873025-1fhwy9-t1080x1080.jpg",
    "https://i.scdn.co/image/ab67616d0000b273e7224fe44691eadd6b765980",
    "https://live.staticflickr.com/7702/16964616127_89fa620ce2.jpg",
    "https://miro.medium.com/v2/resize:fit:1075/1*jd0k6GwmriT5pRZqqb8rNQ.jpeg",
    "https://c.tenor.com/G894zBFxIPoAAAAd/tenor.gif",
    "https://c.tenor.com/ylwZaI8l4BMAAAAd/tenor.gif",
    "https://c.tenor.com/uoMw7DYf7CkAAAAd/tenor.gif",
    "https://c.tenor.com/s_FJJovI_1UAAAAd/tenor.gif",
];

document.addEventListener("turbo:load", () => { // Pour Turbo Rails
    const toggle = document.getElementById("toggle-cats");
    const body = document.body; // Référence au body

    // Récupérer l'état initial sauvegardé dans LocalStorage
    const savedState = localStorage.getItem("toggle-cats-state");
    toggle.checked = (savedState === "true");

    // Appliquer automatiquement l'état du toggle aux images visibles et au fond
    applyToggleStateToImages(toggle.checked);
    updateBodyBackground(toggle.checked);

    // Ajouter un event listener pour surveiller les modifications du toggle
    toggle.addEventListener("change", (event) => {
        const isChecked = event.target.checked;

        // Sauvegarder l'état actuel dans LocalStorage
        localStorage.setItem("toggle-cats-state", isChecked);

        // Mise à jour des images visibles (en GIFs ou en images normales) et du fond
        applyToggleStateToImages(isChecked);
        updateBodyBackground(isChecked);
    });
});

// Fonction : Appliquer l'état du toggle à toutes les images visibles
function applyToggleStateToImages(isChecked) {
    const images = document.querySelectorAll(".cat-image"); // Récupère toutes les images visibles
    if (images.length === 0) {
        console.warn("Aucune image disponible pour être mise à jour !");
        return;
    }

    images.forEach((image, index) => {
        if (isChecked) {
            // Assigner un GIF unique basé sur l'index (par ex. "page 2" reçoit d'autres GIFs)
            const gifUrl = getGifUrlForImage(image, index);
            image.src = gifUrl;
        } else {
            // Restaurer l'image originale
            const originalImage = image.dataset.original;
            if (originalImage) {
                image.src = originalImage;  // Retourne à l'image de départ
            } else {
                console.error("Image originale non trouvée pour cet élément !");
            }
        }
    });
}

function updateBodyBackground(isChecked) {
    const body = document.body;

    if (isChecked) {
        body.classList.add("psychedelic"); 
        body.classList.remove("normal");
    } else {
        body.classList.add("normal"); // Restaure le fond
        body.classList.remove("psychedelic");
    }
}

// Fonction : Sélectionner un GIF unique en fonction de l'image et de la page
function getGifUrlForImage(image, index) {
    const pageOffset = parseInt(new URLSearchParams(window.location.search).get("page") || 1);
    const adjustedIndex = index + (pageOffset - 1) * 10; // Permet de rendre les GIF différents entre les pages
    return psychedelicCatImages[adjustedIndex % psychedelicCatImages.length];
}


document.addEventListener("DOMContentLoaded", () => {
    const morphingElement = document.querySelector('.morphing-color');
    const toggleButton = document.getElementById('toggle-morph');

    toggleButton.addEventListener('click', () => {
        morphingElement.classList.toggle('morphing-color'); // Active/désactive le morphing
    });
});




