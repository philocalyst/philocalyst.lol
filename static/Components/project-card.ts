export class ProjectCard extends HTMLElement {
  connectedCallback() {
    if (this.dataset.upgraded === "true") return;
    this.dataset.upgraded = "true";

    const description = (this.textContent ?? "").trim();
    const title = this.getAttribute("title") ?? "";
    const whatItIs = this.getAttribute("what") ?? "";
    const image = this.getAttribute("img") ?? "";
    const creationDate = this.getAttribute("creation-date") ?? "";
    const imageDescription = this.getAttribute("img-alt") ?? "";

    this.textContent = "";

    const metaText = [creationDate, whatItIs].filter(Boolean).join(" · ");

    const top = Object.assign(document.createElement("div"), {
      className: "card-top",
    });

    const cardHeader = Object.assign(document.createElement("div"), {
      className: "card-header",
    });

    const heading = Object.assign(document.createElement("h3"), {
      textContent: title,
    });

    const meta = Object.assign(document.createElement("p"), {
      className: "card-meta",
      textContent: metaText,
    });

    const cardImage = document.createElement("halftone-image");

cardImage.setAttribute("class", "card-image");
cardImage.setAttribute("alt", imageDescription);
cardImage.setAttribute("src", image);
cardImage.setAttribute("loading", "lazy");

    const cardDescription = Object.assign(document.createElement("p"), {
      className: "card-description",
      textContent: description,
    });

    cardHeader.append(heading, meta);
    top.append(cardHeader, cardImage);
    this.append(top, cardDescription);
  }
}
