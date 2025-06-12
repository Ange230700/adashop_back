// prisma\seed.ts

import prisma from "~/prisma/lib/prismaClient";
import seedEntityTable from "~/prisma/entity_table/seed";

async function main() {
  await seedEntityTable();
}

main()
  .catch((e) => {
    console.error("❌ Error seeding:", e);
    process.exit(1);
  })
  .finally(() => {
    prisma.$disconnect();
  });
