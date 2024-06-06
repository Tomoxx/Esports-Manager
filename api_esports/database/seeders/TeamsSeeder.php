<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TeamsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('teams')->insert([
            ['name' => 'w7m esports', 'game' => 'Rocket League', 'region' => 'South America'],
            ['name' => 'Erased', 'game' => 'Rocket League', 'region' => 'South America'],
        ]);
    }
}
