<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TournamentsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('tournaments')->insert([
            ['name' => 'RLCS 2024 - Major 2: London', 'type' => 'Online', 'game' => 'Rocket League', 'start_date' => '2024-06-20', 'end_date' => '2024-06-23'],
        ]);
    }
}
