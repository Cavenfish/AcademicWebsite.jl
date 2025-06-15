const fs = require("fs");
const sass = require("sass");

function compile_sass() {
  fs.readdirSync("./_sass").forEach((file) => {
    if (file.charAt(0) != "_") {
      const sassFile = "./_sass/" + file;
      const cssFile = "./_css/" + file.replace(".scss", ".css");

      const result = sass.compile(sassFile);

      fs.writeFileSync(cssFile, result.css);
    }
  });
}

function main() {
  compile_sass();
}

main();
