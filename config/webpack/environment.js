import { environment } from "@rails/webpacker";

import webpack from "webpack";
environment.plugins.append(
  "Provide",
  new ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"],
  })
);

export default environment;
