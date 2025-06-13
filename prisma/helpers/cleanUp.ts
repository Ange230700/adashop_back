// prisma\helpers\cleanUp.ts

import prisma from '~/prisma/lib/prismaClient';
import safeDelete from '~/prisma/helpers/deleteSafely';

async function cleanUp() {
  console.log('🧹 Cleaning up...');
  await safeDelete(() => prisma.entity_table.deleteMany({}), 'entity_table');
  console.log('🧹 Cleaning up complete.');
}

export default cleanUp;
