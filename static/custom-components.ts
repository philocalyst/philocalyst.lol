class HalftoneImage extends HTMLElement {
  connectedCallback() {
    const src = this.getAttribute("src") ?? "";
    const alt = this.getAttribute("alt") ?? "";

    const container = document.createElement("div");
    container.className = "halftone-container";

    const cmyLayer = this.createLayer("halftone-cmy", src, alt);
    const inkDiv = document.createElement("div");
    inkDiv.className = "halftone-ink";
    cmyLayer.appendChild(inkDiv);

    const kLayer = this.createLayer("halftone-k", src, "");
    kLayer.querySelector("img")!.setAttribute("aria-hidden", "true");

    container.append(cmyLayer, kLayer);
    this.appendChild(container);
  }

  private createLayer(modifier: string, src: string, alt: string): HTMLDivElement {
    const layer = document.createElement("div");
    layer.className = `halftone-layer ${modifier}`;

    const img = document.createElement("img");
    img.className = "halftone-media";
    img.src = src;
    img.alt = alt;

    layer.appendChild(img);
    return layer;
  }
}

customElements.define("halftone-image", HalftoneImage);
