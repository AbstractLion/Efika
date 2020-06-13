const axios = require("axios");
const fs = require("fs");
function c(string) {
	return string.charAt(0).toUpperCase() + string.slice(1);
}
(async function () {
	const users = [];
	for (let i = 0; i < 40; ++i) {
		const {
			data: {
				results: [results]
			}
		} = await axios.get("https://randomuser.me/api/");
		const user = {
			name: c(results.name.first) + " " + c(results.name.last),
			avatarUrl: results.picture.medium
		};
		users.push(user);
	}

	fs.writeFileSync("users.txt", JSON.stringify(users));
	console.log(users);
	x;
})();
