import fs from "fs";
import crypto from "crypto";

const ens = "ensdeliz.eth";
const cid = "ipfs://b3c926ea29c3eda3...";

const xml = `
<record type="Community" id="LEDL-001">
  <leader>00000n a2200000  4500</leader>
  <controlfield tag="001">${ens}</controlfield>
  <controlfield tag="002">${cid}</controlfield>
</record>
`;

fs.writeFileSync("record.xml", xml);

const hash = crypto.createHash("sha256")
    .update(xml)
    .digest("hex");

console.log("🧠 Record generado");
console.log("SHA256:", hash);
