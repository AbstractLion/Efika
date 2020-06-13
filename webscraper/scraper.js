const cheerio = require("cheerio");
const axios = require("axios");

const baseUrl =
	"https://www.metro.ca/en/online-grocery/aisles/fruits-vegetables-page-";

const numPages = 1;

const urls = [];
const products = [];

(async function () {
	for (let i = 1; i <= numPages; ++i) {
		const { data: html } = await axios.get(`${baseUrl}${i}`);
		const $ = cheerio.load(html);
		$(".tile-product").each(function () {
			urls.push($(this).find("source").eq(0).attr("srcset").split(",")[0]);
			products.push($(this).find(".pt-title").text());
		});
	}

	console.log(urls.join(","));
	console.log(products.join(","));
})();
